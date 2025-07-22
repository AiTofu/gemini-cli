Loaded cached credentials.
## Building and running

## 构建和运行

Before submitting any changes, it is crucial to validate them by running the full preflight check. This command will build the repository, run all tests, check for type errors, and lint the code.

在提交任何变更之前，通过运行完整的预检至关重要。该命令将构建代码仓库、运行所有测试、检查类型错误并对代码进行 lint。

To run the full suite of checks, execute the following command:

要运行全套检查，请执行以下命令：

```bash
npm run preflight
```

This single command ensures that your changes meet all the quality gates of the project. While you can run the individual steps (`build`, `test`, `typecheck`, `lint`) separately, it is highly recommended to use `npm run preflight` to ensure a comprehensive validation.

这个单一命令可确保您的变更符合项目的所有质量门槛。虽然您可以单独运行各个步骤（`build`、`test`、`typecheck`、`lint`），但强烈建议使用 `npm run preflight` 以确保进行全面验证。

## Writing Tests

## 编写测试

This project uses **Vitest** as its primary testing framework. When writing tests, aim to follow existing patterns. Key conventions include:

本项目使用 **Vitest** 作为其主要测试框架。在编写测试时，请遵循现有模式。关键约定包括：

### Test Structure and Framework

### 测试结构和框架

- **Framework**: All tests are written using Vitest (`describe`, `it`, `expect`, `vi`).
- **框架**：所有测试均使用 Vitest（`describe`、`it`、`expect`、`vi`）编写。

- **File Location**: Test files (`*.test.ts` for logic, `*.test.tsx` for React components) are co-located with the source files they test.
- **文件位置**：测试文件（用于逻辑的 `*.test.ts`，用于 React 组件的 `*.test.tsx`）与其测试的源文件并置。

- **Configuration**: Test environments are defined in `vitest.config.ts` files.
- **配置**：测试环境在 `vitest.config.ts` 文件中定义。

- **Setup/Teardown**: Use `beforeEach` and `afterEach`. Commonly, `vi.resetAllMocks()` is called in `beforeEach` and `vi.restoreAllMocks()` in `afterEach`.
- **设置/拆卸**：使用 `beforeEach` 和 `afterEach`。通常，在 `beforeEach` 中调用 `vi.resetAllMocks()`，在 `afterEach` 中调用 `vi.restoreAllMocks()`。

### Mocking (`vi` from Vitest)

### 模拟（来自 Vitest 的 `vi`）

- **ES Modules**: Mock with `vi.mock('module-name', async (importOriginal) => { ... })`. Use `importOriginal` for selective mocking.
- **ES 模块**：使用 `vi.mock('module-name', async (importOriginal) => { ... })` 进行模拟。使用 `importOriginal` 进行选择性模拟。

  - _Example_: `vi.mock('os', async (importOriginal) => { const actual = await importOriginal(); return { ...actual, homedir: vi.fn() }; });`
  - _示例_：`vi.mock('os', async (importOriginal) => { const actual = await importOriginal(); return { ...actual, homedir: vi.fn() }; });`

- **Mocking Order**: For critical dependencies (e.g., `os`, `fs`) that affect module-level constants, place `vi.mock` at the _very top_ of the test file, before other imports.
- **模拟顺序**：对于影响模块级常量的关键依赖项（例如 `os`、`fs`），请将 `vi.mock` 放置在测试文件的_最顶部_，在其他导入之前。

- **Hoisting**: Use `const myMock = vi.hoisted(() => vi.fn());` if a mock function needs to be defined before its use in a `vi.mock` factory.
- **提升**：如果一个模拟函数需要在 `vi.mock` 工厂中使用之前被定义，请使用 `const myMock = vi.hoisted(() => vi.fn());`。

- **Mock Functions**: Create with `vi.fn()`. Define behavior with `mockImplementation()`, `mockResolvedValue()`, or `mockRejectedValue()`.
- **模拟函数**：使用 `vi.fn()` 创建。使用 `mockImplementation()`、`mockResolvedValue()` 或 `mockRejectedValue()` 定义行为。

- **Spying**: Use `vi.spyOn(object, 'methodName')`. Restore spies with `mockRestore()` in `afterEach`.
- **侦测**：使用 `vi.spyOn(object, 'methodName')`。在 `afterEach` 中使用 `mockRestore()` 恢复侦测。

### Commonly Mocked Modules

### 常用的模拟模块

- **Node.js built-ins**: `fs`, `fs/promises`, `os` (especially `os.homedir()`), `path`, `child_process` (`execSync`, `spawn`).
- **Node.js 内置模块**：`fs`、`fs/promises`、`os`（尤其是 `os.homedir()`）、`path`、`child_process`（`execSync`、`spawn`）。

- **External SDKs**: `@google/genai`, `@modelcontextprotocol/sdk`.
- **外部 SDK**：`@google/genai`、`@modelcontextprotocol/sdk`。

- **Internal Project Modules**: Dependencies from other project packages are often mocked.
- **内部项目模块**：来自其他项目包的依赖项通常会被模拟。

### React Component Testing (CLI UI - Ink)

### React 组件测试 (CLI UI - Ink)

- Use `render()` from `ink-testing-library`.
- 使用 `ink-testing-library` 中的 `render()`。

- Assert output with `lastFrame()`.
- 使用 `lastFrame()` 断言输出。

- Wrap components in necessary `Context.Provider`s.
- 将组件包装在必要的 `Context.Provider` 中。

- Mock custom React hooks and complex child components using `vi.mock()`.
- 使用 `vi.mock()` 模拟自定义 React 钩子和复杂的子组件。

### Asynchronous Testing

### 异步测试

- Use `async/await`.
- 使用 `async/await`。

- For timers, use `vi.useFakeTimers()`, `vi.advanceTimersByTimeAsync()`, `vi.runAllTimersAsync()`.
- 对于计时器，使用 `vi.useFakeTimers()`、`vi.advanceTimersByTimeAsync()`、`vi.runAllTimersAsync()`。

- Test promise rejections with `await expect(promise).rejects.toThrow(...)`.
- 使用 `await expect(promise).rejects.toThrow(...)` 测试 promise 的拒绝情况。

### General Guidance

### 一般性指导

- When adding tests, first examine existing tests to understand and conform to established conventions.
- 在添加测试时，首先检查现有测试以理解并遵守既定约定。

- Pay close attention to the mocks at the top of existing test files; they reveal critical dependencies and how they are managed in a test environment.
- 密切关注现有测试文件顶部的模拟；它们揭示了关键依赖项以及在测试环境中如何管理它们。

## Git Repo

## Git 仓库

The main branch for this project is called "main"

本项目的主分支名为 "main"

## JavaScript/TypeScript

## JavaScript/TypeScript

When contributing to this React, Node, and TypeScript codebase, please prioritize the use of plain JavaScript objects with accompanying TypeScript interface or type declarations over JavaScript class syntax. This approach offers significant advantages, especially concerning interoperability with React and overall code maintainability.

在为这个 React、Node 和 TypeScript 代码库做贡献时，请优先使用带有 TypeScript 接口或类型声明的纯 JavaScript 对象，而不是 JavaScript 的 class 语法。这种方法具有显著优势，尤其是在与 React 的互操作性和整体代码可维护性方面。

### Preferring Plain Objects over Classes

### 优先使用纯对象而非类

JavaScript classes, by their nature, are designed to encapsulate internal state and behavior. While this can be useful in some object-oriented paradigms, it often introduces unnecessary complexity and friction when working with React's component-based architecture. Here's why plain objects are preferred:

JavaScript 的 class 本质上是为封装内部状态和行为而设计的。虽然这在某些面向对象的范式中可能很有用，但在使用 React 的基于组件的架构时，它常常会引入不必要的复杂性和摩擦。以下是优先使用纯对象的原因：

- Seamless React Integration: React components thrive on explicit props and state management. Classes' tendency to store internal state directly within instances can make prop and state propagation harder to reason about and maintain. Plain objects, on the other hand, are inherently immutable (when used thoughtfully) and can be easily passed as props, simplifying data flow and reducing unexpected side effects.
- 无缝的 React 集成：React 组件依赖于显式的 props 和状态管理。Class 倾向于将内部状态直接存储在实例中，这使得 props 和状态的传递更难理解和维护。相比之下，纯对象（如果使用得当）本质上是不可变的，可以轻松地作为 props 传递，从而简化数据流并减少意外的副作用。

- Reduced Boilerplate and Increased Conciseness: Classes often promote the use of constructors, this binding, getters, setters, and other boilerplate that can unnecessarily bloat code. TypeScript interface and type declarations provide powerful static type checking without the runtime overhead or verbosity of class definitions. This allows for more succinct and readable code, aligning with JavaScript's strengths in functional programming.
- 减少样板代码并提高简洁性：Class 常常会推广使用构造函数、this 绑定、getter、setter 以及其他可能不必要地使代码膨胀的样板代码。TypeScript 的 interface 和 type 声明提供了强大的静态类型检查，而没有 class 定义带来的运行时开销或冗长。这使得代码更简洁易读，符合 JavaScript 在函数式编程方面的优势。

- Enhanced Readability and Predictability: Plain objects, especially when their structure is clearly defined by TypeScript interfaces, are often easier to read and understand. Their properties are directly accessible, and there's no hidden internal state or complex inheritance chains to navigate. This predictability leads to fewer bugs and a more maintainable codebase.
- 增强可读性和可预测性：纯对象，特别是当其结构由 TypeScript interface 清晰定义时，通常更易于阅读和理解。它们的属性是直接可访问的，没有隐藏的内部状态或复杂的继承链需要追踪。这种可预测性可以减少错误，并使代码库更易于维护。

- Simplified Immutability: While not strictly enforced, plain objects encourage an immutable approach to data. When you need to modify an object, you typically create a new one with the desired changes, rather than mutating the original. This pattern aligns perfectly with React's reconciliation process and helps prevent subtle bugs related to shared mutable state.
- 简化的不可变性：虽然不是严格强制的，但纯对象鼓励采用不可变的数据处理方式。当需要修改一个对象时，通常会创建一个带有期望变更的新对象，而不是改变原始对象。这种模式与 React 的协调过程完美契合，有助于防止因共享可变状态而导致的细微错误。

- Better Serialization and Deserialization: Plain JavaScript objects are naturally easy to serialize to JSON and deserialize back, which is a common requirement in web development (e.g., for API communication or local storage). Classes, with their methods and prototypes, can complicate this process.
- 更好的序列化和反序列化：纯 JavaScript 对象天然易于序列化为 JSON 和反序列化回来，这是 Web 开发中的常见需求（例如，用于 API 通信或本地存储）。而带有方法和原型的 Class 会使这个过程复杂化。

### Embracing ES Module Syntax for Encapsulation

### 拥抱 ES 模块语法以实现封装

Rather than relying on Java-esque private or public class members, which can be verbose and sometimes limit flexibility, we strongly prefer leveraging ES module syntax (`import`/`export`) for encapsulating private and public APIs.

我们强烈建议利用 ES 模块语法（`import`/`export`）来封装私有和公共 API，而不是依赖于类似 Java 的私有或公共类成员，后者可能很冗长，有时还会限制灵活性。

- Clearer Public API Definition: With ES modules, anything that is exported is part of the public API of that module, while anything not exported is inherently private to that module. This provides a very clear and explicit way to define what parts of your code are meant to be consumed by other modules.
- 更清晰的公共 API 定义：使用 ES 模块，任何被导出的内容都是该模块公共 API 的一部分，而任何未被导出的内容本质上都是该模块的私有部分。这提供了一种非常清晰和明确的方式来定义代码的哪些部分是供其他模块使用的。

- Enhanced Testability (Without Exposing Internals): By default, unexported functions or variables are not accessible from outside the module. This encourages you to test the public API of your modules, rather than their internal implementation details. If you find yourself needing to spy on or stub an unexported function for testing purposes, it's often a "code smell" indicating that the function might be a good candidate for extraction into its own separate, testable module with a well-defined public API. This promotes a more robust and maintainable testing strategy.
- 增强的可测试性（不暴露内部实现）：默认情况下，未导出的函数或变量无法从模块外部访问。这鼓励您测试模块的公共 API，而不是其内部实现细节。如果您发现自己为了测试目的需要侦测或存根一个未导出的函数，这通常是一种“代码异味”，表明该函数可能适合提取到一个独立的、具有明确公共 API 的可测试模块中。这有助于推广更健壮和可维护的测试策略。

- Reduced Coupling: Explicitly defined module boundaries through import/export help reduce coupling between different parts of your codebase. This makes it easier to refactor, debug, and understand individual components in isolation.
- 减少耦合：通过 import/export 明确定义的模块边界有助于减少代码库不同部分之间的耦合。这使得在隔离环境中重构、调试和理解单个组件变得更加容易。

### Avoiding `any` Types and Type Assertions; Preferring `unknown`

### 避免 `any` 类型和类型断言；优先使用 `unknown`

TypeScript's power lies in its ability to provide static type checking, catching potential errors before your code runs. To fully leverage this, it's crucial to avoid the `any` type and be judicious with type assertions.

TypeScript 的强大之处在于其提供静态类型检查的能力，可以在代码运行前捕获潜在错误。为了充分利用这一点，避免使用 `any` 类型并审慎使用类型断言至关重要。

- **The Dangers of `any`**: Using any effectively opts out of TypeScript's type checking for that particular variable or expression. While it might seem convenient in the short term, it introduces significant risks:
- **`any` 的危险**：使用 `any` 实际上是让特定变量或表达式退出了 TypeScript 的类型检查。虽然短期内可能看起来很方便，但它会带来巨大的风险：

  - **Loss of Type Safety**: You lose all the benefits of type checking, making it easy to introduce runtime errors that TypeScript would otherwise have caught.
  - **丧失类型安全**：您将失去类型检查的所有好处，从而容易引入 TypeScript 本可以捕获的运行时错误。

  - **Reduced Readability and Maintainability**: Code with `any` types is harder to understand and maintain, as the expected type of data is no longer explicitly defined.
  - **降低可读性和可维护性**：带有 `any` 类型的代码更难理解和维护，因为数据的预期类型没有被明确定义。

  - **Masking Underlying Issues**: Often, the need for any indicates a deeper problem in the design of your code or the way you're interacting with external libraries. It's a sign that you might need to refine your types or refactor your code.
  - **掩盖潜在问题**：通常，对 `any` 的需求表明您的代码设计或与外部库交互的方式存在更深层次的问题。这是一个信号，可能意味着您需要优化类型或重构代码。

- **Preferring `unknown` over `any`**: When you absolutely cannot determine the type of a value at compile time, and you're tempted to reach for any, consider using unknown instead. unknown is a type-safe counterpart to any. While a variable of type unknown can hold any value, you must perform type narrowing (e.g., using typeof or instanceof checks, or a type assertion) before you can perform any operations on it. This forces you to handle the unknown type explicitly, preventing accidental runtime errors.
- **优先使用 `unknown` 而非 `any`**：当您在编译时完全无法确定一个值的类型，并想使用 `any` 时，请考虑使用 `unknown`。`unknown` 是 `any` 的类型安全对应物。虽然 `unknown` 类型的变量可以持有任何值，但在对其执行任何操作之前，您必须进行类型收窄（例如，使用 `typeof` 或 `instanceof` 检查，或类型断言）。这迫使您显式地处理 `unknown` 类型，从而防止意外的运行时错误。

  ```
  function processValue(value: unknown) {
     if (typeof value === 'string') {
        // value is now safely a string
        // value 现在可以安全地视为字符串
        console.log(value.toUpperCase());
     } else if (typeof value === 'number') {
        // value is now safely a number
        // value 现在可以安全地视为数字
        console.log(value * 2);
     }
     // Without narrowing, you cannot access properties or methods on 'value'
     // 如果不进行类型收窄，则无法访问“value”上的属性或方法
     // console.log(value.someProperty); // Error: Object is of type 'unknown'.
     // console.log(value.someProperty); // 错误：对象类型为“unknown”。
  }
  ```

- **Type Assertions (`as Type`) - Use with Caution**: Type assertions tell the TypeScript compiler, "Trust me, I know what I'm doing; this is definitely of this type." While there are legitimate use cases (e.g., when dealing with external libraries that don't have perfect type definitions, or when you have more information than the compiler), they should be used sparingly and with extreme caution.
- **类型断言 (`as Type`) - 谨慎使用**：类型断言告诉 TypeScript 编译器：“相信我，我知道我在做什么；这绝对是这个类型。” 虽然存在合法用例（例如，处理没有完美类型定义的外部库，或者当您拥有比编译器更多的信息时），但应谨慎使用。

  - **Bypassing Type Checking**: Like `any`, type assertions bypass TypeScript's safety checks. If your assertion is incorrect, you introduce a runtime error that TypeScript would not have warned you about.
  - **绕过类型检查**：与 `any` 类似，类型断言会绕过 TypeScript 的安全检查。如果您的断言不正确，就会引入一个 TypeScript 不会警告您的运行时错误。

  - **Code Smell in Testing**: A common scenario where `any` or type assertions might be tempting is when trying to test "private" implementation details (e.g., spying on or stubbing an unexported function within a module). This is a strong indication of a "code smell" in your testing strategy and potentially your code structure. Instead of trying to force access to private internals, consider whether those internal details should be refactored into a separate module with a well-defined public API. This makes them inherently testable without compromising encapsulation.
  - **测试中的代码异味**：在试图测试“私有”实现细节（例如，侦测或存根模块内未导出的函数）时，`any` 或类型断言可能很诱人。这强烈表明您的测试策略乃至代码结构中存在“代码异味”。与其试图强制访问私有内部实现，不如考虑是否应将这些内部细节重构为一个具有明确公共 API 的独立模块。这使得它们在不破坏封装性的前提下具有内在的可测试性。

### Embracing JavaScript's Array Operators

### 拥抱 JavaScript 的数组操作符

To further enhance code cleanliness and promote safe functional programming practices, leverage JavaScript's rich set of array operators as much as possible. Methods like `.map()`, `.filter()`, `.reduce()`, `.slice()`, `.sort()`, and others are incredibly powerful for transforming and manipulating data collections in an immutable and declarative way.

为了进一步提高代码的整洁性并推广安全的函数式编程实践，请尽可能多地利用 JavaScript 丰富的数组操作符。像 `.map()`、`.filter()`、`.reduce()`、`.slice()`、`.sort()` 等方法在以不可变和声明式的方式转换和操作数据集合方面非常强大。

Using these operators:

使用这些操作符：

- Promotes Immutability: Most array operators return new arrays, leaving the original array untouched. This functional approach helps prevent unintended side effects and makes your code more predictable.
- 促进不可变性：大多数数组操作符会返回新数组，而保持原数组不变。这种函数式方法有助于防止意外的副作用，并使您的代码更具可预测性。

- Improves Readability: Chaining array operators often lead to more concise and expressive code than traditional for loops or imperative logic. The intent of the operation is clear at a glance.
- 提高可读性：链式调用数组操作符通常比传统的 for 循环或命令式逻辑产生更简洁、更具表现力的代码。操作的意图一目了然。

- Facilitates Functional Programming: These operators are cornerstones of functional programming, encouraging the creation of pure functions that take inputs and produce outputs without causing side effects. This paradigm is highly beneficial for writing robust and testable code that pairs well with React.
- 促进函数式编程：这些操作符是函数式编程的基石，鼓励创建接收输入并产生输出而无副作用的纯函数。这种范式对于编写与 React 良好配合的健壮且可测试的代码非常有益。

By consistently applying these principles, we can maintain a codebase that is not only efficient and performant but also a joy to work with, both now and in the future.

通过始终如一地应用这些原则，我们可以维护一个不仅高效、高性能，而且在当前和未来都令人愉悦地使用的代码库。

## React (mirrored and adjusted from [react-mcp-server](https://github.com/facebook/react/blob/4448b18760d867f9e009e810571e7a3b8930bb19/compiler/packages/react-mcp-server/src/index.ts#L376C1-L441C94))

## React (镜像并调整自 [react-mcp-server](https://github.com/facebook/react/blob/4448b18760d867f9e009e810571e7a3b8930bb19/compiler/packages/react-mcp-server/src/index.ts#L376C1-L441C94))

### Role

### 角色

You are a React assistant that helps users write more efficient and optimizable React code. You specialize in identifying patterns that enable React Compiler to automatically apply optimizations, reducing unnecessary re-renders and improving application performance.

您是一名 React 助手，帮助用户编写更高效、更可优化的 React 代码。您专注于识别能让 React 编译器自动应用优化的模式，从而减少不必要的重新渲染并提高应用性能。

### Follow these guidelines in all code you produce and suggest

### 在您生成和建议的所有代码中遵循以下准则

Use functional components with Hooks: Do not generate class components or use old lifecycle methods. Manage state with useState or useReducer, and side effects with useEffect (or related Hooks). Always prefer functions and Hooks for any new component logic.

使用带有钩子的函数式组件：不要生成类组件或使用旧的生命周期方法。使用 useState 或 useReducer 管理状态，使用 useEffect（或相关钩子）处理副作用。对于任何新的组件逻辑，始终优先使用函数和钩子。

Keep components pure and side-effect-free during rendering: Do not produce code that performs side effects (like subscriptions, network requests, or modifying external variables) directly inside the component's function body. Such actions should be wrapped in useEffect or performed in event handlers. Ensure your render logic is a pure function of props and state.

在渲染期间保持组件纯净且无副作用：不要在组件函数体内直接编写执行副作用（如订阅、网络请求或修改外部变量）的代码。此类操作应包装在 useEffect 中或在事件处理程序中执行。确保您的渲染逻辑是 props 和 state 的纯函数。

Respect one-way data flow: Pass data down through props and avoid any global mutations. If two components need to share data, lift that state up to a common parent or use React Context, rather than trying to sync local state or use external variables.

尊重单向数据流：通过 props 向下传递数据，避免任何全局突变。如果两个组件需要共享数据，请将该状态提升到共同的父组件或使用 React Context，而不是试图同步本地状态或使用外部变量。

Never mutate state directly: Always generate code that updates state immutably. For example, use spread syntax or other methods to create new objects/arrays when updating state. Do not use assignments like state.someValue = ... or array mutations like array.push() on state variables. Use the state setter (setState from useState, etc.) to update state.

永远不要直接改变状态：始终生成以不可变方式更新状态的代码。例如，在更新状态时使用扩展语法或其他方法创建新的对象/数组。不要在状态变量上使用像 `state.someValue = ...` 这样的赋值或像 `array.push()` 这样的数组突变。使用状态设置器（来自 useState 的 setState 等）来更新状态。

Accurately use useEffect and other effect Hooks: whenever you think you could useEffect, think and reason harder to avoid it. useEffect is primarily only used for synchronization, for example synchronizing React with some external state. IMPORTANT - Don't setState (the 2nd value returned by useState) within a useEffect as that will degrade performance. When writing effects, include all necessary dependencies in the dependency array. Do not suppress ESLint rules or omit dependencies that the effect's code uses. Structure the effect callbacks to handle changing values properly (e.g., update subscriptions on prop changes, clean up on unmount or dependency change). If a piece of logic should only run in response to a user action (like a form submission or button click), put that logic in an event handler, not in a useEffect. Where possible, useEffects should return a cleanup function.

准确使用 useEffect 和其他效果钩子：每当您认为可以使用 useEffect 时，请更深入地思考和推理以避免使用它。useEffect 主要仅用于同步，例如将 React 与某些外部状态同步。重要提示 - 不要在 useEffect 中调用 setState（useState 返回的第二个值），因为这会降低性能。在编写效果时，请在依赖项数组中包含所有必要的依赖项。不要抑制 ESLint 规则或省略效果代码使用的依赖项。正确构建效果回调以处理值的变化（例如，在 props 变化时更新订阅，在卸载或依赖项变化时进行清理）。如果一段逻辑只应在响应用户操作（如表单提交或按钮点击）时运行，请将该逻辑放在事件处理程序中，而不是 useEffect 中。在可能的情况下，useEffect 应返回一个清理函数。

Follow the Rules of Hooks: Ensure that any Hooks (useState, useEffect, useContext, custom Hooks, etc.) are called unconditionally at the top level of React function components or other Hooks. Do not generate code that calls Hooks inside loops, conditional statements, or nested helper functions. Do not call Hooks in non-component functions or outside the React component rendering context.

遵循钩子规则：确保任何钩子（useState、useEffect、useContext、自定义钩子等）都在 React 函数组件或其他钩子的顶层无条件调用。不要生成在循环、条件语句或嵌套辅助函数内部调用钩子的代码。不要在非组件函数或 React 组件渲染上下文之外调用钩子。

Use refs only when necessary: Avoid using useRef unless the task genuinely requires it (such as focusing a control, managing an animation, or integrating with a non-React library). Do not use refs to store application state that should be reactive. If you do use refs, never write to or read from ref.current during the rendering of a component (except for initial setup like lazy initialization). Any ref usage should not affect the rendered output directly.

仅在必要时使用 ref：除非任务确实需要（例如聚焦控件、管理动画或与非 React 库集成），否则避免使用 useRef。不要使用 ref 来存储应具有反应性的应用程序状态。如果确实使用 ref，切勿在组件渲染期间写入或读取 `ref.current`（除非是像延迟初始化这样的初始设置）。任何 ref 的使用都不应直接影响渲染输出。

Prefer composition and small components: Break down UI into small, reusable components rather than writing large monolithic components. The code you generate should promote clarity and reusability by composing components together. Similarly, abstract repetitive logic into custom Hooks when appropriate to avoid duplicating code.

优先使用组合和小型组件：将 UI 分解为小型的、可重用的组件，而不是编写大型的单体组件。您生成的代码应通过组合组件来提高清晰度和可重用性。同样，在适当时将重复逻辑抽象为自定义钩子，以避免代码重复。

Optimize for concurrency: Assume React may render your components multiple times for scheduling purposes (especially in development with Strict Mode). Write code that remains correct even if the component function runs more than once. For instance, avoid side effects in the component body and use functional state updates (e.g., setCount(c => c + 1)) when updating state based on previous state to prevent race conditions. Always include cleanup functions in effects that subscribe to external resources. Don't write useEffects for "do this when this changes" side effects. This ensures your generated code will work with React's concurrent rendering features without issues.

为并发进行优化：假设 React 可能会出于调度目的多次渲染您的组件（尤其是在开发中的严格模式下）。编写即使组件函数运行多次也能保持正确的代码。例如，避免在组件主体中产生副作用，并在基于先前状态更新状态时使用函数式状态更新（例如，`setCount(c => c + 1)`）以防止竞争条件。始终在订阅外部资源的效果中包含清理函数。不要为“当此更改时执行此操作”的副作用编写 useEffect。这可确保您生成的代码能够与 React 的并发渲染功能无缝协作。

Optimize to reduce network waterfalls - Use parallel data fetching wherever possible (e.g., start multiple requests at once rather than one after another). Leverage Suspense for data loading and keep requests co-located with the component that needs the data. In a server-centric approach, fetch related data together in a single request on the server side (using Server Components, for example) to reduce round trips. Also, consider using caching layers or global fetch management to avoid repeating identical requests.

优化以减少网络瀑布 - 尽可能使用并行数据获取（例如，一次启动多个请求而不是一个接一个）。利用 Suspense 进行数据加载，并将请求与需要数据的组件放在一起。在以服务器为中心的方法中，在服务器端通过单个请求一起获取相关数据（例如，使用服务器组件）以减少往返次数。此外，考虑使用缓存层或全局获取管理来避免重复相同的请求。

Rely on React Compiler - useMemo, useCallback, and React.memo can be omitted if React Compiler is enabled. Avoid premature optimization with manual memoization. Instead, focus on writing clear, simple components with direct data flow and side-effect-free render functions. Let the React Compiler handle tree-shaking, inlining, and other performance enhancements to keep your code base simpler and more maintainable.

依赖 React 编译器 - 如果启用了 React 编译器，可以省略 useMemo、useCallback 和 React.memo。避免使用手动记忆化进行过早优化。相反，应专注于编写具有直接数据流和无副作用渲染函数的清晰、简单的组件。让 React 编译器处理摇树、内联和其他性能增强，以保持您的代码库更简单、更易于维护。

Design for a good user experience - Provide clear, minimal, and non-blocking UI states. When data is loading, show lightweight placeholders (e.g., skeleton screens) rather than intrusive spinners everywhere. Handle errors gracefully with a dedicated error boundary or a friendly inline message. Where possible, render partial data as it becomes available rather than making the user wait for everything. Suspense allows you to declare the loading states in your component tree in a natural way, preventing “flash” states and improving perceived performance.

为良好的用户体验而设计 - 提供清晰、简约且非阻塞的 UI 状态。当数据加载时，显示轻量级占位符（例如，骨架屏），而不是到处都是侵入性的加载指示器。使用专用的错误边界或友好的内联消息优雅地处理错误。在可能的情况下，在数据可用时渲染部分数据，而不是让用户等待所有内容。Suspense 允许您以自然的方式在组件树中声明加载状态，从而防止“闪烁”状态并提高感知性能。

### Process

### 流程

1. Analyze the user's code for optimization opportunities:
1. 分析用户的代码以寻找优化机会：

   - Check for React anti-patterns that prevent compiler optimization
   - 检查妨碍编译器优化的 React 反模式

   - Look for component structure issues that limit compiler effectiveness
   - 寻找限制编译器效率的组件结构问题

   - Think about each suggestion you are making and consult React docs for best practices
   - 思考您提出的每一条建议，并查阅 React 文档以获取最佳实践

2. Provide actionable guidance:
2. 提供可行的指导：

   - Explain specific code changes with clear reasoning
   - 用清晰的理由解释具体的代码变更

   - Show before/after examples when suggesting changes
   - 在建议变更时展示前后对比示例

   - Only suggest changes that meaningfully improve optimization potential
   - 只建议那些能显著提高优化潜力的变更

### Optimization Guidelines

### 优化指南

- State updates should be structured to enable granular updates
- 状态更新的结构应能实现精细化更新

- Side effects should be isolated and dependencies clearly defined
- 副作用应被隔离，并明确定义其依赖关系

## Comments policy

## 注释政策

Only write high-value comments if at all. Avoid talking to the user through comments.

只在必要时编写高价值的注释。避免通过注释与用户对话。

## General style requirements

## 通用样式要求

Use hyphens instead of underscores in flag names (e.g. `my-flag` instead of `my_flag`).

在标志名称中使用连字符而不是下划线（例如，`my-flag` 而不是 `my_flag`）。
